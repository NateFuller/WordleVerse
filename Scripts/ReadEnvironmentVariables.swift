#!/usr/bin/env xcrun swift
//
//  ReadEnvironmentVariables.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/12/22.
//  A rough copy-pasta of Josh Kaplan's
//  https://github.com/trilemma-dev/SwiftAuthorizationSample/blob/main/BuildScripts/PropertyListModifier.swift
//

import Foundation

/// Errors raised throughout this script.
enum ScriptError: Error {
  case general(String)
  case wrapped(String, Error)
}

// MARK: helper functions to read environment variables

/// Attempts to read an environment variable, throws an error if it is not present.
///
/// - Parameters:
///   - name: Name of the environment variable.
///   - description: A description of what was trying to be read; used in the error message if one is thrown.
///   - isUserDefined: Whether the environment variable is user defined; used to modify the error message if one is thrown.
func readEnvironmentVariable(name: String, description: String, isUserDefined: Bool) throws -> String {
  if let value = ProcessInfo.processInfo.environment[name] {
    return value
  } else {
    var message = "Unable to determine \(description), missing \(name) environment variable."
    if isUserDefined {
      message += " This is a user-defined variable. Please check that the xcconfig files are present and " +
        "configured in the project settings."
    }
    throw ScriptError.general(message)
  }
}

// MARK: - Property List Manipulation

/// Reads the property list at the provided path.
///
/// - Parameters:
///   - atPath: Where the property list is located.
/// - Returns: Tuple containing entries and the format of the on disk property list.
func readPropertyList(atPath path: URL) throws -> (entries: NSMutableDictionary,
                                                   format: PropertyListSerialization.PropertyListFormat)
{
  let onDiskPlistData: Data
  do {
    onDiskPlistData = try Data(contentsOf: path)
  } catch {
    throw ScriptError.wrapped("Unable to read property list at: \(path)", error)
  }

  do {
    var format = PropertyListSerialization.PropertyListFormat.xml
    let plist = try PropertyListSerialization.propertyList(from: onDiskPlistData,
                                                           options: .mutableContainersAndLeaves,
                                                           format: &format)
    if let entries = plist as? NSMutableDictionary {
      return (entries: entries, format: format)
    } else {
      throw ScriptError.general("Unable to cast parsed property list")
    }
  } catch {
    throw ScriptError.wrapped("Unable to parse property list", error)
  }
}

/// Writes (or overwrites) a property list at the provided path.
///
/// - Parameters:
///   - atPath: Where the property list should be written.
///   - entries: All entries to be written to the property list, this does not append - it overwrites anything existing.
///   - format:The format to use when writing entries to `atPath`.
func writePropertyList(atPath path: URL,
                       entries: NSDictionary,
                       format: PropertyListSerialization.PropertyListFormat) throws
{
  let plistData: Data
  do {
    plistData = try PropertyListSerialization.data(fromPropertyList: entries,
                                                   format: format,
                                                   options: 0)
  } catch {
    throw ScriptError.wrapped("Unable to serialize property list in order to write to path: \(path)", error)
  }

  do {
    try plistData.write(to: path)
  } catch {
    throw ScriptError.wrapped("Unable to write property list to path: \(path)", error)
  }
}

/// Updates the property list with the provided entries.
///
/// If an existing entry exists for the given key it will be overwritten. If the property file does not exist, it will be created.
func updatePropertyListWithEntries(_ newEntries: [String: AnyHashable], atPath path: URL) throws {
  let (entries, format): (NSMutableDictionary, PropertyListSerialization.PropertyListFormat)
  if FileManager.default.fileExists(atPath: path.path) {
    (entries, format) = try readPropertyList(atPath: path)
  } else {
    (entries, format) = ([:], PropertyListSerialization.PropertyListFormat.xml)
  }

  for (key, value) in newEntries {
    entries.setValue(value, forKey: key)
  }

  try writePropertyList(atPath: path, entries: entries, format: format)
}

// Script starts here

do {
  print("✍️  Adding AD_MOB_APP_ID to Info.plist from $PATH...")
  let adMobAppID = try readEnvironmentVariable(name: "AD_MOB_APP_ID",
                                               description: "app id for google ad mob",
                                               isUserDefined: true)
  let adMobAppIDKey = "GADApplicationIdentifier"
  let plistUpdates = [adMobAppIDKey: adMobAppID]

  try updatePropertyListWithEntries(plistUpdates, atPath: URL(fileURLWithPath: "./Recordle/Info.plist"))
  print("✅ Done")
} catch let ScriptError.general(message) {
  print("❌ error: \(message)")
  exit(1)
} catch let ScriptError.wrapped(message, wrappedError) {
  print("❌ error: \(message)")
  print("❌ internal error: \(wrappedError)")
  exit(2)
} catch {
  print("❌ unexpected error: \(error.localizedDescription)")
}
